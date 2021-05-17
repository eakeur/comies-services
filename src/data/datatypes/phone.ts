import {Entity, PrimaryGeneratedColumn, Column, ManyToOne} from "typeorm";
import Costumer from "./costumer";

@Entity()
export class Phone {

    @PrimaryGeneratedColumn()
    id: number;

    @Column({nullable:false})
    ddd: string;

    @Column({nullable:false})
    number: string;

    @ManyToOne(()=> Costumer, costumer => costumer.phones)
    costumer:Costumer;

}