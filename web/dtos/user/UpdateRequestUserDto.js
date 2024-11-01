export default class UpdateRequestUserDto {
    constructor({username, email, password}) {
        this.username = username;
        this.email = email;
        this.password = password;
    }
};