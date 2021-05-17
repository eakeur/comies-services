export {Connection} from './core/connection';

export * as Validators from './core/validators';


/**
 * Conglomerado de repositórios de erros padrões 
 */
export {
    ForbiddenError,
    MissingInformationError,
    InvalidInformationError,
    UnauthorizedError
} from './core/error-reporting';
