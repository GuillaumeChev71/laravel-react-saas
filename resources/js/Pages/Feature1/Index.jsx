import InputError from "@/Components/InputError";
import InputLabel from "@/Components/InputLabel";
import TextInput from "@/Components/TextInput";
import PrimaryButton from "@/Components/PrimaryButton";
import { useForm } from "@inertiajs/react";
import Feature from "@/Components/Feature";
import { use } from "react";


export default function Index({ feature, answer }) {


    const { data, setData, post, processing, errors } = useForm({
        number1: '',
        number2: '',
    });

    const submit = (e) => {
        e.preventDefault();
        post(route('feature1.calculate'), {
            onSuccess: () => {
                reset();
            }
        });
    }

    return ( 

        <Feature feature={feature} answer={answer}>
            <form onSubmit={submit} className="p-8 grid grid-cols-2 gap-3">
                
            </form>
        </Feature>



    );

}