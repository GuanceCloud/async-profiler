/*
 * Copyright The async-profiler authors
 * SPDX-License-Identifier: Apache-2.0
 */

#include <dlfcn.h>
#include <stdlib.h>
#include "hooks.h"
#include "profiler.h"


// This should be called only after all other statics are initialized.
// Therefore, put it in the last file in the alphabetic order.
class LateInitializer {
  public:
    LateInitializer() {
        const char* command = getenv("ASPROF_COMMAND");
        if (command != NULL && !isJavaApp() && Hooks::init(false)) {
            startProfiler(command);
        }
    }

  private:
    bool isJavaApp() {
        void* libjvm = dlopen(OS::isLinux() ? "libjvm.so" : "libjvm.dylib", RTLD_LAZY | RTLD_NOLOAD);
        if (libjvm != NULL) {
            dlclose(libjvm);
            return true;
        }
        return false;
    }

    void startProfiler(const char* command) {
        Error error = _global_args.parse(command);
        _global_args._preloaded = true;

        Log::open(_global_args);
        Log::info("_http_out: %d, _dd_agent_host: %s, _dd_trace_agent_port: %d, _dd_service: %s, _dd_env: %s, _dd_version: %s, _dd_tags: %s",
        _global_args._http_out, _global_args._dd_agent_host, _global_args._dd_trace_agent_port, _global_args._dd_service, _global_args._dd_env, _global_args._dd_version, _global_args._dd_tags);

        if (error || (error = Profiler::instance()->run(_global_args))) {
            Log::error("%s", error.message());
        }
    }
};

static LateInitializer _late_initializer;
