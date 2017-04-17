import sys
import time
import os
import diff_match_patch as dmp_module



def checkArgv():
	if len(sys.argv) < 3:
		print ('use me like this to get a patch from bundle2 to bundle1: python seperateBundle.py 1.jsbundle 2.jsbundle')
		return False

	reference = sys.argv[1];#reference file
	lastest = sys.argv[2];
	if not os.path.isfile(reference):
		print ('reference not exit')
		return False;

	if not os.path.isfile(lastest):
		print ('lastest not exit')
		return False;

	return True;



def readFileToText(filePath):
	file = open(filePath,"r")
	s = ''
	for line in file:
    		s = s + line
	return s
    
if not checkArgv():
	exit(0)

dmp = dmp_module.diff_match_patch()

reference = sys.argv[1];
print('reference: ' + reference);

lastest = sys.argv[2];
print('lastest: ' + lastest);

referenceText = readFileToText(reference)
lastestText = readFileToText(lastest)

patch = dmp.patch_make(referenceText, lastestText)
patchText = dmp.patch_toText(patch)

patchFilePath = os.getcwd() + '/business.patch'
print('patch location: ' + patchFilePath)
patchFile = open(patchFilePath,"w")
patchFile.write(patchText)

