// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "remix_tests.sol";
import "../todoListPendingCountSeconds.sol";

contract TodoListTest {
    TodoList todoList;

    function beforeEach() public {
        todoList = new TodoList();
    }

    function testAddTodo() public {
        todoList.addTodo("Buy groceries");
        uint256 count = todoList.getTodoCount();
        Assert.equal(count, 1, "Incorrect todo count");
    }

    function testSetCompleted() public {
        todoList.addTodo("Buy groceries");
        todoList.setCompleted(0);
        uint256 completedCount = todoList.getCompletedCount();
        uint256 todoCount = todoList.getTodoCount();
        Assert.equal(completedCount, 1, "Incorrect completed count");
        Assert.equal(todoCount, 0, "Incorrect todo count");
    }

    function testSetPending() public {
        todoList.addTodo("Buy groceries");
        todoList.setPending(0);
        uint256 pendingCount = todoList.getPendingCount();
        uint256 todoCount = todoList.getTodoCount();
        Assert.equal(pendingCount, 1, "Incorrect pending count");
        Assert.equal(todoCount, 0, "Incorrect todo count");
    }

    function testGetTodoByIndex() public {
        todoList.addTodo("Buy groceries");
        string memory todo = todoList.getTodoByIndex(0);
        Assert.equal(todo, "Buy groceries", "Incorrect todo content");
    }

    function testDeleteTodoByIndex() public {
        todoList.addTodo("Buy groceries");
        todoList.deleteTodoByIndex(0);
        uint256 count = todoList.getTodoCount();
        Assert.equal(count, 0, "Incorrect todo count");
    }

    function testGetCompletedByIndex() public {
        todoList.addTodo("Buy groceries");
        todoList.setCompleted(0);
        string memory completed = todoList.getCompletedByIndex(0);
        Assert.equal(completed, "Buy groceries", "Incorrect completed content");
    }

    function testGetPendingByIndex() public {
        todoList.addTodo("Buy groceries");
        todoList.setPending(0);
        string memory pending = todoList.getPendingByIndex(0);
        Assert.equal(pending, "Buy groceries", "Incorrect pending content");
    }

    function testGetAllTodo() public {
        todoList.addTodo("Buy groceries");
        todoList.addTodo("Walk the dog");
        string[] memory allTodo = todoList.getAllTodo();
        Assert.equal(allTodo.length, 2, "Incorrect todo count");
        Assert.equal(allTodo[0], "Buy groceries", "Incorrect todo content");
        Assert.equal(allTodo[1], "Walk the dog", "Incorrect todo content");
    }

    function testGetAllCompleted() public {
        todoList.addTodo("Buy groceries");
        todoList.setCompleted(0);
        string[] memory allCompleted = todoList.getAllCompleted();
        Assert.equal(allCompleted.length, 1, "Incorrect completed count");
        Assert.equal(
            allCompleted[0],
            "Buy groceries",
            "Incorrect completed content"
        );
    }

    function testGetAllPending() public {
        todoList.addTodo("Buy groceries");
        todoList.setPending(0);
        string[] memory allPending = todoList.getAllPending();
        Assert.equal(allPending.length, 1, "Incorrect pending count");
        Assert.equal(
            allPending[0],
            "Buy groceries",
            "Incorrect pending content"
        );
    }

    function testClearCompleted() public {
        todoList.addTodo("Buy groceries");
        todoList.setCompleted(0);
        todoList.clearCompleted();
        uint256 count = todoList.getCompletedCount();
        Assert.equal(count, 0, "Incorrect completed count");
    }

}
