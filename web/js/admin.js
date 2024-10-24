import UserModel from '../model/user/UserModel.js'
import UserViewModel from '../viewmodel/UserViewModel/UserViewModel.js'

const url = 'http://localhost:5245/backend/account'
const userModel = new UserModel(url)
const userViewModel = new UserViewModel(userModel);


window.getAllUser = async() => { 
    await userViewModel.fetchAndUpdateUsers();
};