    local recoilSettings = {
        SMG = {
            recoilMouseMoveAmount = 5,
            recoilHorizontalAmount = 0,
            mouseMoveDelaySleep = 5
        },
        Shotgun = {
            recoilMouseMoveAmount = 8,
            recoilHorizontalAmount = 0,
            mouseMoveDelaySleep = 5
        },
        AR = {
            recoilMouseMoveAmount = 12,
            recoilHorizontalAmount = 0,
            mouseMoveDelaySleep = 5
        },
        NewSetting = {
            recoilMouseMoveAmount = 6,
            recoilHorizontalAmount = 2,
            mouseMoveDelaySleep = 5
        }
    }




    --CODE BELOW NO TOUCHIE

    local controlOptions = {
        lockKey = "scrolllock",
        toggleKey = "capslock",
        alternateToggleKey = "numlock"
    }

    local lc = 1 -- Left Click
    local rc = 3 -- Right Click

    local currentSetting = "SMG"




    function CheckForRecoilSetting()
        local toggleKeyState = IsKeyLockOn(controlOptions.toggleKey)
        local alternateToggleKeyState = IsKeyLockOn(controlOptions.alternateToggleKey)
        local lockKeyState = IsKeyLockOn(controlOptions.lockKey)

        if toggleKeyState and alternateToggleKeyState and lockKeyState then
            currentSetting = "NewSetting"
        elseif toggleKeyState then
            currentSetting = "Shotgun"
        elseif alternateToggleKeyState then
            currentSetting = "AR"
        else
            currentSetting = "SMG"
        end

        MoveMouseRelative(recoilSettings[currentSetting].recoilHorizontalAmount, recoilSettings[currentSetting].recoilMouseMoveAmount)
    end


    function Resetter()
        Countx = 0
    end

    function RecoilControl()
        repeat
            CheckForRecoilSetting()
            Sleep(recoilSettings[currentSetting].mouseMoveDelaySleep)

            if IsMouseButtonPressed(rc) and IsKeyLockOn(controlOptions.lockKey) then
                NoRecoil()
                Resetter()
            end
        until not IsMouseButtonPressed(lc)
    end

    function NoRecoil()
        repeat
            CheckForRecoilSetting()
            Sleep(recoilSettings[currentSetting].mouseMoveDelaySleep)
        until not IsMouseButtonPressed(lc)
    end

    function OnEvent(event, arg)
        EnablePrimaryMouseButtonEvents(true)

        if event == "MOUSE_BUTTON_PRESSED" and arg == lc then
            Sleep(25)

            if IsMouseButtonPressed(rc) and IsKeyLockOn(controlOptions.lockKey) then
                RecoilControl()
            end
        end

        if event == "MOUSE_BUTTON_PRESSED" and arg == rc then
            repeat
                if IsMouseButtonPressed(lc) then
                    Resetter()
                elseif IsKeyLockOn(controlOptions.toggleKey) then
                    Resetter()
                else
                    Sleep(15)
                end
            until not IsMouseButtonPressed(rc)
        end
    end