<?php

namespace App\Http\Controllers;

use App\Models\Package;

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

    public function buyCredits(Package $package) {

        $stripe = new \Stripe\StripeClient(env('STRIPE_SECRET_KEY'));

        $checkout_session = $stripe->checkout->sessions->create([
            'line_items' => [
                [
                    'price_data' => [
                        'currency' =>'usd',
                        'product_data' => [
                            'name' => $package->name . ' - ' .
                            $package->credits . ' credits',
                        ],
                        'unit_amont' => $package->price * 100,
                    ],
                    'quantity' => 1,
                ]
            ],
            'mode'=>'payment',
            'success_url' => route('credit.success',[],true),
            'cancel_url' => route('credit.cancel',[],true),
        ]);

    }

    public function success() {}

    public function cancel() {}

    public function webhook() {}
}
