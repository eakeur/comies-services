import { Filter } from "../structs/filter";

export interface OrderFilter extends Filter {
    clientPhone: string,
    clientId: number,
    operatorId: number,
    operatorNickname: string,
    active: boolean,
    initialDate: Date,
    finalDate: Date,
}