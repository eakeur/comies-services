import { ServerResponse, STATUS_CODES } from "http";
import { BadRequestError, HttpCode, NotFoundError } from "routing-controllers";

export class StandardController {

    protected returnError(response: ServerResponse, error: any){

    }
    private badRequest(): NotFoundError {
        return new 
    }
}

export function returnError(response: ServerResponse, error: any): ServerResponse {
    switch (error.code) {
        case 'MISSING': response.statusCode = 
            
            break;
    
        default:
            break;
    }
}