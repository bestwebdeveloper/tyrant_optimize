MAIN := tuo.exe
SRCS := $(wildcard *.cpp)
OBJS := $(patsubst %.cpp,obj/%.o,$(SRCS))
INCS := $(wildcard *.h)

ifndef VERSION
VERSION = $(shell git describe --tags --abbrev=0 --dirty)
ifeq ($(VERSION),)
VERSION=NO VERSION
${warning "VERSION is not set (USING NO VERSION instead), use make VERSION=vX.XX.X"}
endif
endif

CPPFLAGS := -Wall -Werror -std=gnu++11 -Ofast -DNDEBUG -DNQUEST -DTYRANT_OPTIMIZER_VERSION='"$(VERSION)"' 
LDFLAGS := -lboost_system -lboost_thread -lboost_filesystem -lboost_regex -lboost_timer

all: $(MAIN)

obj/%.o: %.cpp $(INCS)
	-@if not exist "obj" mkdir "obj"
	$(CXX) $(CPPFLAGS) -o $@ -c $<

$(MAIN): $(OBJS)
	$(CXX) -o $@ $(OBJS) $(LDFLAGS)

rebuild: clean all

clean:
	del /q $(MAIN) obj\*.o
