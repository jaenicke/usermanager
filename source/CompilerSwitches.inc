{.$define DEBUG}

{$ifdef DEBUG}
   {$D+}
   {$L+}
   {$C+}
   //{$Q+}
   //{$R+}
   {$HINTS ON}
   {$WARNINGS ON}
{$else}
   {$D-}
   {$L-}
   {$C-}
   {$Q-}
   {$R-}
   {$YD-}
   {$HINTS OFF}
   {$WARNINGS OFF}
{$endif}