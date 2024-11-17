export default class UpdateRequestTaskDto {
    constructor(name, description, priority, deadTime, status)
    {
        this.name = name,
        this.description = description,
        this.priority = priority,
        this.deadTime = deadTime,
        this.status = status
    };
}