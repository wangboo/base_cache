defmodule BaseCache do
	
	defmacro new_cache(file_path) do
		"./base_cache/#{file_path}.ECF" |> File.open!(:read) |> IO.read!(:all) |> Quinn.parse		
	end

end