import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout";
import {Head, Link, usePage} from "@inertiajs/react";

export default function Feature({feature, answer,children}) {
    return (
        <div>
            <h2>{feature.name}</h2>
            <p>{feature.description}</p>
            <p>Required Credits: {feature.required_credits}</p>
        </div>
    );
}
