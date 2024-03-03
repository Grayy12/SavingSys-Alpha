-- ALPHA MADE BY: Grayy#6068 https://discord.com/users/339838833489346560

local SaveSys = {}

local function CheckFile(filepath)
	if isfile(filepath) then
		return true
	else
		return false
	end
end

function SaveSys.Init(Folder: string?, File: string)
	local self = {}
	local exists = true
	if not isfolder or not isfile then
		warn("File Saving is not supported on this executor")
		return
	end

	if not Folder and not File then
		warn("Plase provide a folder and file name")
		return
	end
	if Folder ~= "" then
		self._FilePath = ("%s/%s"):format(Folder, File)
	else
		self._FilePath = File
	end

	self._Folder = Folder or ""

	if not isfolder(Folder) then
		makefolder(Folder)
	end
	
	if not isfile(self._FilePath) then
		exists = false
		writefile(self._FilePath, "")
	end

	function self:Save(Data: table, override: boolean?, encrypt: boolean?)
		override = override or false
		-- TODO: Add encryption
		if not CheckFile(self._FilePath) then
			warn("File does not exist")
			return
		end

		if not override then
			local OldData = self:Load()

			for i, v in next, OldData do
				Data[i] = v
			end
		end
		local Data = game:GetService("HttpService"):JSONEncode(Data)
		writefile(self._FilePath, Data)
	end

	function self:Load(encrypted: boolean?): table
		-- TODO: Add encryption
		if not CheckFile(self._FilePath) then
			warn("File does not exist")
			return
		end

		local Data = readfile(self._FilePath)

		if Data == "" then
			return {}
		end

		return game:GetService("HttpService"):JSONDecode(Data)
	end

	return self, exists
end

return SaveSys
