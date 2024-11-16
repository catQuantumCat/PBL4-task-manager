import DeleteRequestUserDto from '../dtos/user/DeleteRequestUserDto.js';
import UserRepository from '../repository/UserRepository.js';
import UserViewModel from '../viewmodel/UserViewModel/UserViewModel.js'

const url = 'http://localhost:5245/backend/account'
const userRepository = new UserRepository();
const userViewModel = new UserViewModel(userRepository);


window.getAllUser = async() => { 
    await userViewModel.fetchAndUpdateUsers();
};

window.editUser = async(userName) => {
    window.location.href = `../html/user/edit-user.html?username='${encodeURIComponent(userName)}'`;
};

window.deleteUser = async(userName) => {
    const deleteDto = new DeleteRequestUserDto({username : userName});
    try {
        userRepository.deleteUser(deleteDto);
        window.location.reload();
    } catch (err) {
        console.log("Something went wrong" + err);
    }
    
};

window.taskOfUser = async(userName) => {
    window.location.href = `../html/task/user-tasks.html?username='${encodeURIComponent(userName)}'`;
}