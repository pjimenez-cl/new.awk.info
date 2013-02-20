BEGIN   { initialize() }
            { spell_check_line() }
END         { report_exceptions() }
