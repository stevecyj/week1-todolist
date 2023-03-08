// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract TodoList {
    struct Todo {
        string content;
        uint256 createTime;
        bool isPending;
    }

    Todo[] public todos;
    Todo[] public todoCompleted;
    Todo[] public todoPending;
    uint256 public constant n = 1; // n 秒

    constructor() {}

    function addTodo(string memory content) external {
        todos.push(Todo({
        content : content,
        createTime : block.timestamp,
        isPending : false
        }));
    }

    function setCompleted(uint256 index) external {
        Todo memory completedTodo = todos[index];

        for (uint256 i = index; i < todos.length - 1; i++) {
            todos[i] = todos[i + 1];
        }
        todos.pop();

        todoCompleted.push(completedTodo);
    }

    function setPending(uint256 index) external {
        Todo memory pendingTodo = todos[index];

        require(!pendingTodo.isPending, "Todo is already pending");

        for (uint256 i = index; i < todos.length - 1; i++) {
            todos[i] = todos[i + 1];
        }
        todos.pop();

        if (block.timestamp - pendingTodo.createTime > n) {
            todoPending.push(pendingTodo);
        } else {
            pendingTodo.isPending = true;
            todoPending.push(pendingTodo);
        }
    }

    function getTodoCount() external view returns (uint256) {
        return todos.length;
    }

    function getCompletedCount() external view returns (uint256) {
        return todoCompleted.length;
    }

    function getPendingCount() external view returns (uint256) {
        return todoPending.length;
    }

    function getTodoByIndex(uint256 index) external view returns (string memory) {
        return todos[index].content;
    }

    function deleteTodoByIndex(uint256 index) external {
        for (uint256 i = index; i < todos.length - 1; i++) {
            todos[i] = todos[i + 1];
        }
        todos.pop();
    }

    function getCompletedByIndex(uint256 index) external view returns (string memory) {
        return todoCompleted[index].content;
    }

    function getPendingByIndex(uint256 index) external view returns (string memory) {
        return todoPending[index].content;
    }

    function getAllTodo() external view returns (string[] memory) {
        string[] memory result = new string[](todos.length);
        for (uint256 i = 0; i < todos.length; i++) {
            result[i] = todos[i].content;
        }
        return result;
    }

    function getAllCompleted() external view returns (string[] memory) {
        string[] memory result = new string[](todoCompleted.length);
        for (uint256 i = 0; i < todoCompleted.length; i++) {
            result[i] = todoCompleted[i].content;
        }
        return result;
    }

    function getAllPending() external view returns (string[] memory) {
        string[] memory result = new string[](todoPending.length);
        for (uint256 i = 0; i < todoPending.length; i++) {
            result[i] = todoPending[i].content;
        }
        return result;
    }

    function clearCompleted() external {
        delete todoCompleted;
    }

    function clearPending(uint256 index) external {
        uint256 createTime = todoPending[index].createTime;
        require(block.timestamp - createTime > n, "Pending is not expired yet");

        for (uint256 i = index; i < todoPending.length - 1; i++) {
            todoPending[i] = todoPending[i + 1];
        }
        todoPending.pop();
    }
}
