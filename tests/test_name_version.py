def test_get_app_and_version(cmd, hid):
    
    if hid:
        # for now it doesn't work with Speculos
        app_name, version = cmd.get_app_and_version()

        print(app_name)
        print(version)

        assert app_name == "ARCHEthic"
        assert version == "1.0.1"