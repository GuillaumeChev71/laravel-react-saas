import InputError from "@/Components/InputError";
import InputLabel from "@/Components/InputLabel";
import TextInput from "@/Components/TextInput";
import PrimaryButton from "@/Components/PrimaryButton";
import { useForm } from "@inertiajs/react";
import Feature from "@/Components/Feature";
import { use } from "react";


export default function Index({ feature, answer }) {


    const {data, setData, post, processing, errors} = useForm({
        number: '',
    });

    


}