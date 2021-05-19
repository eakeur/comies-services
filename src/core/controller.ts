import { ServerResponse } from "http";
import { BadRequestError, HttpCode, NotFoundError } from "routing-controllers";
import { FriendlyError } from "../data";

export class StandardController {

    protected error(response: ServerResponse, error: any): void {
        if (error instanceof FriendlyError && error.comiesDomain){
            switch (error.code){
                case'INVALID': response.statusCode = 400; response.write(JSON.stringify(response)); break;
                case'MISSING': response.statusCode = 400; response.write(JSON.stringify(response)); break;
                case'UNAUTHORIZED': response.statusCode = 401; response.write(JSON.stringify(response)); break;
                case'FORBIDDEN': response.statusCode = 403; response.write(JSON.stringify(response)); break;
                case'NOTFOUND': response.statusCode = 404; response.write(JSON.stringify(response)); break;
                default: break;
            }
        }
    }
}