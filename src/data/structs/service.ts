import { Filter } from './filter';
import { Operator } from '../datatypes/operator';

export interface Service<T, K> {

    operator: Operator;

    add(value: T): Promise<T>;
    get(value: K): Promise<T>;
    remove(value: K): Promise<T>;
    update(value: T): Promise<T>;

    getMany(value: Filter): Promise<T[]>;
    


}