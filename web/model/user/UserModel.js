export default class UserModel {
    constructor(url) {
        this.url = url;
    }

    async getAllUsers() {
        try {
            const response = await fetch(this.url);
            return await response.json();
        } catch (error) {
            console.error('Error fetching users:', error);
            throw error;
        }
    }
}
