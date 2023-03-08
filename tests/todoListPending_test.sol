// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "remix_tests.sol";
import "../todoListPending.sol";

contract TodoListTest {
    TodoList todoList;

    function beforeEach() public {
        todoList = new TodoList();
    }

    function testAddTodo() public {
        todoList.addTodo("Buy groceries");

        string[] memory todos = todoList.getAllTodo();
        string memory expected = "Buy groceries";

        Assert.equal(todos[0], expected, "Should add todo.");
    }

    function testGetTodo() public {
        todoList.addTodo("Buy groceries");

        string memory todo = todoList.getTodo(0);
        string memory expected = "Buy groceries";

        Assert.equal(todo, expected, "Should get todo.");
    }

    function testDeleteTodo() public {
        todoList.addTodo("Buy groceries");

        todoList.deleteTodo(0);

        string[] memory todos = todoList.getAllTodo();
        uint256 expected = 0;

        Assert.equal(todos.length, expected, "Should delete todo.");
    }

    function testSetCompleted() public {
        todoList.addTodo("Buy groceries");

        todoList.setCompleted(0);

        string[] memory completed = todoList.getAllCompleted();
        string[] memory todos = todoList.getAllTodo();

        uint256 expectedCompleted = 1;
        uint256 expectedTodos = 0;

        Assert.equal(completed.length, expectedCompleted, "Should set todo as completed.");
        Assert.equal(todos.length, expectedTodos, "Should remove todo from todos.");
    }

    function testSetPending() public {
        todoList.addTodo("Buy groceries");

        todoList.setPending(0);

        string[] memory pending = todoList.getAllPending();
        string[] memory todos = todoList.getAllTodo();

        uint256 expectedPending = 1;
        uint256 expectedTodos = 0;

        Assert.equal(pending.length, expectedPending, "Should set todo as pending.");
        Assert.equal(todos.length, expectedTodos, "Should remove todo from todos.");
    }

    function testClearCompleted() public {
        //        TodoList todolist = new TodoList();
        todoList.addTodo("test todo");
        todoList.setCompleted(0);

        todoList.clearCompleted();

        string[] memory completed = todoList.getAllCompleted();

        Assert.equal(completed.length, 0, "Completed array should be empty");
    }
}
