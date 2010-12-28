-- Copyright (c) 2010 by Robert G. Jakabosky <bobby@neoawareness.com>
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

local socket = require'handler.nixio.socket'
local ev = require'ev'
local loop = ev.Loop.default

local tcp_client_mt = {
handle_error = function(this, err)
	print('tcp_client.error:', err)
end,
handle_connected = function(this)
	print('tcp_client.connected')
end,
handle_data = function(this, data)
	print('tcp_client.data:', data)
end,
}
tcp_client_mt.__index = tcp_client_mt

-- new tcp client
local function new_tcp_client(host, port)
	local this = setmetatable({}, tcp_client_mt)
	this.sck = socket.tcp(loop, this, host, port)
	return this
end

-- new tcp server
local function new_server(port, handler)
	print('New tcp server listen on: ' .. port)
	return acceptor.new(loop, handler, '*', port, 1024)
end

local host, port = (arg[1] or 'localhost:8081'):match('^([^:]*):(.*)$')
local client = new_tcp_client(host, port)

loop:loop()

