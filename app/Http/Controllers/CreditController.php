<?php

namespace App\Http\Controllers;

use App\Models\Package;
use App\Models\Transaction;

class CreditController extends Controller
{
    public function index()
    {

        $packages = Package::all();
        $features = Feature::where('active', true)->get();

        return inertia('Credit/index', [
            'packages' => PackageResource::collection($packages),
            'features' => FeatureResource::collection($features),
            'success' => session('success'),

        ]);

    }

    public function buyCredits(Package $package)
    {

        $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));

        $checkout_session = $stripe->checkout->sessions->create([
            'line_items' => [
                [
                    'price_data' => [
                        'currency' => 'usd',
                        'product_data' => [
                            'name' => $package->name.' - '.
                            $package->credits.' credits',
                        ],
                        'unit_amont' => $package->price * 100,
                    ],
                    'quantity' => 1,
                ],
            ],
            'mode' => 'payment',
            'success_url' => route('credit.success', [], true),
            'cancel_url' => route('credit.cancel', [], true),
        ]);

        Transaction::create([

            'status' => 'pending',
            'price' => $package->price,
            'credits' => $package->credits,
            'session_id' => $checkout_session->id,
            'user_id' => Auth::id(),
            'package_id' => $package->id,
        ]);

        return redirect($checkout_session->url);

    }

    public function success()
    {

        return to_route('credit.index')->with('success', 'You have succesfully bought new credits.');

    }

    public function cancel()
    {
        return to_route('credit.index')->with('success', 'There was an error in payment process. Please try again.');
    }

    public function webhook()
    {

        // This is your Stripe CLI webhook secret for testing your endpoint locally

        $endpoint_secret = env('STRIPE_WEBHOOK_KEY');

        $payload = @file_get_contents('php://input');
        $sig_header = $_SERVER['HTTP_STRIPE_SIGNATURE'];
        $event = null;

        try {
            $event = \Stripe\Webhook::constructEvent(
                $payload,
                $sig_header,
                $endpoint_secret
            );
        } catch (\UnexpectedValueException $e) {
            //invalid payload
            return response('',400);
        } catch (\Stripe\Exception\SignatureVerificationException $e) {
            //invalid signature 
            return response('', 400);
        }

        //Handle the event
        switch ($event->type) {
            case 'checkout.session.completed':
                $session = $event->data->object;


            //handle other types    
            default:
                echo 'Received unknow event type ' . $event->type;
        }


    }
}
