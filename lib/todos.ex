defmodule Todos do
  
  def help do
    IO.puts("1. make_tasks - makes a list of tasks; takes 0 args\n")
    IO.puts("2. write - writes the list to a file; takes 1 argument, todos, being the list of tasks\n")
    IO.puts("3. read - prints out the file where tasks are being stored; takes 1 argument, file\n")
    IO.puts("4. finished_task - deletes a task from the list, rewrites the file; takes 2 arguments, todos(the list), file")
  end

  def write(todos) do
    file = IO.gets("Filename: ") |> String.trim
    binary = :erlang.term_to_binary(todos)
    File.write(file, binary)
  end

  def read(file) do
    case File.read(file) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "Brih, that file is not existent."
    end
  end

  def make_tasks do
    {num_of_tasks, _} = IO.gets("Number of tasks: ") |> Integer.parse
    
    for _ <- 1..num_of_tasks do
      IO.gets("Task: ") |> String.trim
    end
  end

  def finished_task(todos, file) do
    task = IO.gets("task: ") |> String.trim

    if Enum.member?(todos, task) do
      new_list = List.delete(todos, task)
      binary = :erlang.term_to_binary(new_list)
      File.write(file, binary)
      new_list
    else
      IO.puts("Brih, you don't need to finish that chor.")
    end

  end

end
