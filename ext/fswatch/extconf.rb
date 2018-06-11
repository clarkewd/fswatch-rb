require 'mkmf'

$CXXFLAGS += " -std=c++11 "

HEADER_DIRS = [
  '/opt/local/include',
  '/usr/local/include',
  '/usr/include',
].select { |d| Dir.exists?(d) }

LIB_DIRS = [
  '/opt/local/lib',
  '/usr/local/lib',
  '/usr/lib',
].select { |d| Dir.exists?(d) }

$srcs = Dir.glob(File.join(File.expand_path('..', __FILE__), '*.c'))

dir_config('fswatch', HEADER_DIRS, LIB_DIRS)

unless find_header('libfswatch/c/libfswatch.h')
  abort "libfswatch is missing.  please install libfswatch"
end

unless find_library('fswatch', 'fsw_init_library')
  abort "libfswatch is missing.  please install libfswatch"
end

unless have_func('fsw_is_running')
  abort 'libfswatch version >= 1.11.3 is required. Please upgrade!'
end

create_makefile('fswatch/fswatch')
