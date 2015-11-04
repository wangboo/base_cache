defmodule BaseCache do
	
	defmacro new_cache(file_path) do
		{:ok, file} = "base_cache/#{file_path}.ECF" |> File.open([:read])
		[%{name: :ITEMTABLE, value: value}] = IO.read(file, :all) |> Quinn.parse	
		File.close(file)
		[%{name: :LineAttrs, value: item_defs},%{name: :LineTexts, value: items}] = value
		item_defs = Enum.reduce(item_defs,%{},fn(%{attr: [CN: _, EN: key, Type: type]},s)-> 
			Map.put(s,String.to_atom(key),String.to_atom(type))
		end)
		# items = Enum.map(items, &parse_item(item_defs,&1))
		item = Enum.map(items, fn(item)-> parse_item(item_defs,item[:value]) end)
		# IO.inspect items
		quote do 
			1
		end
	end

	def parse_item(item_defs, item) do
		data = %{}
		for column <- item do 
			key = column[:name]
			key_type = item_defs[key]
			[value] = column[:value]
			IO.puts "set_item_field key = #{key}, value = #{value}"
			data = set_item_field(key_type,data,key,value)
			IO.inspect(data)
		end 
		
	end 

	def set_item_field(:int,data,key,value), do: Map.put(data,key,String.to_integer(value))
	def set_item_field(:float,data,key,value), do: Map.put(data,key,String.to_float(value))
	def set_item_field(_,data,key,value), do: Map.put(data,key,value)

end