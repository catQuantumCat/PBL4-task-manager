import UserView from "../../view/UserLogicView/UserView.js";

export default class UserViewModel {
    constructor(userRepository) {
        this.userRepo = userRepository
        this.users = [];
    }

    async fetchAndUpdateUsers() {
        try {
            this.users = await this.userRepo.getAllUsers();
            this.updateView();
        } catch (error) {
            console.error('Error updating view:', error);
        }
    }

    updateView() {
        UserView.renderUsers(this.users);
    }
}
