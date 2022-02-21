use Test::Nginx::Socket::Lua no_plan;

run_tests();

__DATA__

=== TEST 1: rewrite by ngx_http_rewrite_module
--- config
    server_rewrite_by_lua_block {
        ngx.log(ngx.INFO, "uri is ", ngx.var.uri)
    }

    rewrite ^ /rewrited;

    location /rewrited {
        content_by_lua_block {
            ngx.say("REWRITED")
        }
    }

    location /ok {
       	content_by_lua_block {
       	    ngx.say("OK")
       	}
    }
--- request
GET /lua
--- response_body
REWRITED
--- error_log
uri is /rewrited
--- no_error_log
[error]
