export default class TaskView {
    static renderTasks(tasks) {
        const htmls = tasks.map((task) => {
            return `
                <tr>
                    <td>${task.id}</td>
                    <td>${task.name}</td>
                    <td>${task.description}</td>
                    <td>${task.priority}</td>
                    <td>${task.createTime}</td>
                    <td>${task.deadTime}</td>
                    <td>${task.status}</td>
                    <td>
                        <div class="button-group">
                            <button onclick="editTask('${task.id}')" class="edit-btn">Edit</button>
                            <button onclick="deleteTask('${task.id}')" class="delete-btn">Delete</button>
                        </div>
                    </td>
                </tr>`;
        }).join("");

        document.querySelector('table tbody').innerHTML = htmls;
    }
}
