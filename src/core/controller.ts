import { ServerResponse } from "http";
import { BadRequestError, HttpCode, NotFoundError } from "routing-controllers";
import { FriendlyError } from "../data";

export class StandardController {

    protected error(response: ServerResponse, error: any): void {
        if (error instanceof FriendlyError && error.comiesDomain){
            switch (error.code){
                case'MISSING': response.statusCode = 400; response.write(JSON.stringify(response)); break;
                default: break;
            }
        }
    }
}