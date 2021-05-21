import { createConnection, Connection as c } from 'typeorm';
import "reflect-metadata";

export class Connection {

    public static db:c;

    public static secret:string = '2001EncryptionConfigurationSecret@))!';

    public static async connect(){
        if (process.env.HOME === '/home/igor'){
            Connection.db = await createConnection("production");
        } else {
            Connection.db = await createConnection("production");
        }

    }

    public static async initializeDatabase(){
        try {

        } catch (error){
            console.log(error);
        }
    }

}