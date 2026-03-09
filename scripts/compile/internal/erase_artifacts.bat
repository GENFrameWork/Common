echo Remove directory %1

if exist %1\Platforms\.vs (
rmdir /s /q %1\Platforms\.vs
)

if exist %1\Platforms\out (
rmdir /s /q %1\Platforms\out
)

if exist %1\Platforms\Windows (
rmdir /s /q %1\Platforms\Windows
)

if exist %1\Platforms\Linux (
rmdir /s /q %1\Platforms\Linux
)

if exist %1\Platforms\Android (
rmdir /s /q %1\Platforms\Android
)
