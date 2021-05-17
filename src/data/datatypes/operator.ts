import {Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany} from "typeorm";
import {Order} from "./order";
import {Partner} from "./partner";
import { Profile } from "./profile";
import {Store} from "./store";

@Entity()
export class Operator {

    @PrimaryGeneratedColumn()
    id: number;

    @Column({nullable:false})
    name: string;

    @Column({nullable:false})
    identification: string;

    @Column({nullable:false})
    password: string;


    @Column()
    lastLogin: Date;

    @ManyToOne(() => Profile, profile => profile.operators, { eager: true })
    profile: Profile;

    @Column({ nullable: false })
    profileID: number;

    @ManyToOne(() => Store, store => store.operators, { eager: true })
    store: Store;

    @Column({ nullable: false })
    storeID: number;

    @ManyToOne(() => Partner, partner => partner.operators, { eager: true })
    partner: Partner;

    @Column({ nullable: false })
    partnerID: number;

    @OneToMany(() => Order, order => order.operator)
    orders: Order[];

    @Column({default: true})
    active: boolean;

}