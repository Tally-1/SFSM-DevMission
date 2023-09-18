_self set ["last_fipo_handling", time];

private _azFipos = (_self get "fipos") apply {_x getVariable "azFipoData"};

{_x call ["fipoActions"]} forEach _azFipos;

true;