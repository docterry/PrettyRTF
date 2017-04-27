/*	PrettyRTF
	Try to format ugly RTF into something more readable
*/

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%

txt = 
(
{\rtf\ansi\deff0{\fonttbl{\f0\froman Tms Rmn;}{\f1\fdecor 
Symbol;}{\f2\fswiss Helv;}}{\colortbl;\red0\green0\blue0;
\red0\green0\blue255;\red0\green255\blue255;\red0\green255\
blue0;\red255\green0\blue255;\red255\green0\blue0;\red255\
green255\blue0;\red255\green255\blue255;}{\stylesheet{\fs20 
\snext0Normal;}}{\info{\author John Doe}
{\creatim\yr1990\mo7\dy30\hr10\min48}{\version1}{\edmins0}
{\nofpages1}{\nofwords0}{\nofchars0}{\vern8351}}\widoctrl\ftnbj \sectd\linex0\endnhere \pard\plain \fs20 This is plain text.\par}
)

clipboard := fmt(txt)

ExitApp

fmt(rtf) {
	; Remove breaks
	StringReplace, rtf, rtf, `n, , All
	
	x := 1
	Loop, Parse, rtf
	{
		k := A_LoopField
		if (k = "{") {
			out .= "`n"
			Loop, % x 
			{
				out .= "	"
			}
			x += 1
		} else if (k = "}") {
			out .= "}`n"
			x -= 1
			Loop, % x-1
			{
				out .= "	"
			}
			continue
		}
		out .= k
	}
	
return out
}