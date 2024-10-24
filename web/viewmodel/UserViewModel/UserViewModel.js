
import UserView from '../../view/UserLogicView/UserView.js';

export default class UserViewModel {
    constructor(userModel) {
        this.userModel = userModel;
        this.users = [];
    }

    async fetchAndUpdateUsers() {
        try {
            this.users = await this.userModel.getAllUsers();
            this.updateView();
        } catch (error) {
            console.error('Error updating view:', error);
        }
    }

    updateView() {
        UserView.renderUsers(this.users);
    }
}
