export default class UserView {
    static renderUsers(users) {
        const htmls = users.map((user, index) => {
            return `
                <tr>
                    <td>${index + 1}</td>
                    <td>${user.userName}</td>
                    <td>${user.email}</td>
                    <td>
                        <button class="edit-btn">Edit</button>
                        <button class="delete-btn">Delete</button>
                        <button class="task-btn">Tasks</button>
                    </td>
                </tr>`;
        }).join("");

        document.querySelector('table tbody').innerHTML = htmls;
    }
}
