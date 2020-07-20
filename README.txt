
Before script execution, please carefully read all below instructions.

Version 1.0: Initial Release
-----------------------------
1. Below files are mandatory for script execution:
SecurityCodeReview_(version).bat
README.txt
StringToSearch.txt
exclusionList.txt

2. "codePath" is the root of your application code. 
For example: If your code is available at "c:\mycode\app1" then "codePath" should be "c:\mycode\app1".

3. "appName" - Provide application name or/and date "DDMMYYYY" format. 
For example: DemoApp01012020

4. "StringToSearch.txt" file is having list of keywords, which will be searched through this script. Before starting, update list as per your requirement. one keyword in one line only.

5. "exclusionList.txt" file is containing file(s) or folder(s) list (with complete path) which are not going to deploy in Production or you want to exclude them. Before starting please check with Dev team for any update in it.

6. All script outputs will be available inside script folder "Output_(appName)". 
For ex. If you have placed this script at "c:\myscript" then all script outputs files available here only.
