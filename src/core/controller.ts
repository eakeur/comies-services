import { ServerResponse } from "http";
import { FriendlyError } from "../data";

export class StandardController {

    protected error(response: ServerResponse, error: any): void {
        if (error instanceof FriendlyError && error.comiesDomain){
            switch (error.code){
                case'INVALID': response.statusCode = 400; response.write(JSON.stringify(error)); break;
                case'MISSING': response.statusCode = 400; response.write(JSON.stringify(error)); break;
                case'UNAUTHORIZED': response.statusCode = 401; response.write(JSON.stringify(error)); break;
                case'FORBIDDEN': response.statusCode = 403; response.write(JSON.stringify(error)); break;
                case'NOTFOUND': response.statusCode = 404; response.write(JSON.stringify(error)); break;
                default: response.statusCode = 500; response.write(JSON.stringify(error)); break;
            }
        } else {
            response.statusCode = 500;
            response.write(JSON.stringify('Ops! Um erro inesperado aconteceu.'));
        }
    }

    protected success(response: ServerResponse, error: any): void {
        if (error instanceof FriendlyError && error.comiesDomain){
            switch (error.code){
                case'INVALID': response.statusCode = 400; response.write(JSON.stringify(error)); break;
                case'MISSING': response.statusCode = 400; response.write(JSON.stringify(error)); break;
                case'UNAUTHORIZED': response.statusCode = 401; response.write(JSON.stringify(error)); break;
                case'FORBIDDEN': response.statusCode = 403; response.write(JSON.stringify(error)); break;
                case'NOTFOUND': response.statusCode = 404; response.write(JSON.stringify(error)); break;
                default: response.statusCode = 500; response.write(JSON.stringify(error)); break;
            }
        } else {
            response.statusCode = 500;
            response.write(JSON.stringify('Ops! Um erro inesperado aconteceu.'));
        }
    }
}