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

    public function buyCredits(Package $package) {}

    public function success() {}

    public function cancel() {}

    public function webhook() {}
}
