import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout";
import { Head, Link, usePage } from "@inertiajs/react";

export default function Feature({ feature, answer, children }) {

    const { auth } = usePage().props;

    const availableCredits = auth.user.available_credits;

    return (
        <AuthenticatedLayout
            user={auth.user}
            header={<h2 className="font-semibold text-xl text-gray-200 leading-tight">
                {feature.name}
            </h2>}
        >
            <Head title={feature.name} />

            <div className="py-12">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    {answer !== null && (
                        <div className="mb-3 py-3 px-5 rounded text-white bg-emerald-600 text-xl">
                            Result of the calculation: {answer}
                        </div>
                    )}
                    <div className="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg relative">
                        {availableCredits !== null &&
                            feature.credit_cost > availableCredits && (
                                <div className="absolute left-0 top-0 right-0 bottom-0 z-20 flex flex-col
                                    items-center justify-center bg-white/70 gap-3">

                                    <img src="/images/lock.svg" alt="Locked" className="w-20 h-20" />
                                    <div>You do not have enough credits to use this feature. Go {"  "}
                                        <Link href='/'
                                              className="underline">
                                            Buy more credits
                                        </Link>.</div>
                                </div>
                            )}

                            <div className="p-8 text-gray-400 border-b pb-4">
                                <p>{feature.description}</p>
                                <p className="text-sm italic text-right">
                                    Requires {feature.required_credits} credits.
                                </p>
                            </div>
                            {children}
                    </div>
                </div>
            </div>
        </AuthenticatedLayout>
    );
}
