import {Phone} from './datatypes/phone';
import {Address} from './datatypes/address';
import {Order} from './datatypes/order';
import {Product} from './datatypes/product';
import {Operator} from './datatypes/operator';
import {Item} from './datatypes/item';
import {Partner} from './datatypes/partner';
import { Profile } from './datatypes/profile';
import {Store} from './datatypes/store';
import {ItemGroup} from './datatypes/item-group';
import {PartnerConfiguration} from './datatypes/partner-configurations';
import {Costumer} from './datatypes/costumer';
import {Connection} from './../core/connection';


export const CostumersCollection = Connection.db.getRepository<Costumer>(Costumer);
export const AddressesCollection = Connection.db.getRepository<Address>(Address);
export const PhonesCollection = Connection.db.getRepository<Phone>(Phone);
export const OrdersCollection = Connection.db.getRepository<Order>(Order);
export const ProductsCollection = Connection.db.getRepository<Product>(Product);
export const OperatorsCollection = Connection.db.getRepository<Operator>(Operator);
export const PartnersCollection = Connection.db.getRepository<Partner>(Partner);
export const StoresCollection = Connection.db.getRepository<Store>(Store);
export const ItemsCollection = Connection.db.getRepository<Item>(Item);
export const ItemsGroupsCollection = Connection.db.getRepository<ItemGroup>(ItemGroup);
export const ProfilesCollection = Connection.db.getRepository<Profile>(Profile);
export const ConfigurationsCollection = Connection.db.getRepository<PartnerConfiguration>(PartnerConfiguration);

export { FindConditions } from 'typeorm';