export default class UserView {
    static renderUsers(users) {
        const htmls = users.map((user, index) => {
            return `
                <tr>
                    <td>${index + 1}</td>
                    <td>${user.userName}</td>
                    <td>${user.email}</td>
                    <td>
                        <button onclick="editUser('${user.userName}')" class="edit-btn">Edit</button>
                        <button onclick="deleteUser('${user.userName}')" class="delete-btn">Delete</button>
                        <button onclick="taskOfUser('${user.userName}')" class="task-btn">Tasks</button>
                    </td>
                </tr>`;
        }).join("");

        document.querySelector('table tbody').innerHTML = htmls;
    }
}
