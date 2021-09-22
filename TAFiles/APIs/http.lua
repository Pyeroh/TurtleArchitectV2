http = setmetatable(
  {
    gist = {
      get = function(code,file)
        local paste
        local response = http.get("https://gist.github.com/"..code)
        if response then
        --sucesss
          if file == true then
            --save to table
            local tLines = {}
            local line = response.readLine()
            while line do
              tLines[#tLines+1] = line
              line = response.readLine()
            end
            return tLines
          elseif file then
            --save to file
            local paste = response.readAll()
            response.close()
            local file = fs.open(file,"w")
            file.write(paste)
            file.close()
            return true
          else
            --save to variable
            local paste = response.readAll()
            response.close()
            return paste
          end
        else
          --failure
          return false
        end
      end
    }
  },
  {
    __index = _G.http
  }
)