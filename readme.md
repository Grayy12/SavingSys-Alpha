# Saving System Alpha

## Introduction
### You can save data for your Roblox script using this *alpha* script. This can be used to save anything you require.

## Loadstring

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Grayy12/SavingSys-Alpha/main/src.lua", true))()
```

## How To
### Here is an example script

```lua
local SavingSystem =
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Grayy12/SavingSys-Alpha/main/src.lua", true))()

local File = SavingSystem.Init("ExampleFolder", "ExampleFile") -- Find or create a file in the ExampleFolder folder called ExampleFile
-- A Folder is not required, if you do not provide one it will save in the workspace directory

local infomation = {
	["Name"] = "Grayy",
	["FortniteBattlePass"] = true,
} -- This is the data we want to save keep in mind that it must be a table and if you use a key,
--  ex. ["Name"] all the oher items must have a key aswell or they will not save ones with a key

File:Save(infomation, true) -- Save the data to the file if you pass true as the second argument it will override the file

local LoadedData = File:Load() -- Load the data from the file returns a table

print(LoadedData["Name"]) -- Prints Grayy

```

### Keep in mind that this is just an alpha
