#!/usr/bin/env ruby
#
#== NAME
#     testlink_api_client : RUby client to insert results to testlink 
#
#== SYNOPSIS
#      testlink_api_client.rb [ --help ] 
#
#==EXAMPLES
# client = TestlinkAPIClient.new()
# p client.reportTCResult('MDM 0.9' , 'TESTPLAN NAME',	'TEST CASE NAME', "STATUS" , "RESULT NOTES")
# 
#      Valid Values for status :
#	p - 'PASSED'
#	f - 'FAILED'
#	b - 'BLOCKED'

require 'xmlrpc/client'
require 'getoptlong'
require 'pp'

class TestlinkAPIClient  
  SERVER_URL = "http://adqatestlink.np.wc1.yellowpages.com/lib/api/xmlrpc.php"
  TEST_STATUS = ['p','f','b']
  
  
  def initialize()
    @server = XMLRPC::Client.new2(SERVER_URL)
    @devKey = 'automation'
  end
    
  def reportTCResult(testprojectname, testplaname, testcasename, status, notes, buildname)
  	raise "\n\nInvalid Status code for results . \n\tValid Values : #{TEST_STATUS.join(',')}\n" if ! TEST_STATUS.include?(status) 

  	testplanid = getTestPlanIdFromProjectNameAndTestPlanName(testprojectname,testplaname)
  	raise "\n\nCant Find Testplan : #{testplaname}\n" if testplanid.nil?
  	
  	new_build = createBuild(testplanid, buildname, "This is to test cucumber reporting")

  	testcaseid = getTestCaseIdFromName(testprojectname,testcasename)
  	raise "\n\nCant Find TestCase: #{testcasename}\n" if testcaseid.nil?
	
 	  args = {"devKey"=>@devKey,"testcaseid" => testcaseid['id'], "testplanid" => testplanid, "platformname" =>"Automation",
    "status" => status , "notes" => notes, "buildid" => new_build[0]['id']}

  	return @server.call("tl.reportTCResult", args)
  end
  
  def createBuild(testplanid, buildname, buildnotes)
      args = {"devKey"=>@devKey, "testplanid"=>testplanid, "buildname"=>buildname, "buildnotes"=>buildnotes}
      return @server.call("tl.createBuild", args)
  end
    
  def getLatestBuildForTestPlan(testplanid)
      args = {"devKey"=>@devKey, "testplanid"=>testplanid}
      return @server.call("tl.getLatestBuildForTestPlan", args)
  end

  def getTestSuiteByID(testsuiteid)
    args = {"devKey"=>@devKey, "testsuiteid"=>testsuiteid}
    return @server.call("tl.getTestSuiteByID", args)
  end

  def getProjects()
    args = {"devKey"=>@devKey}
    return @server.call("tl.getProjects", args)
  end

  def getFirstLevelTestSuitesForTestProject(testprojectid)
    args = {"devKey"=>@devKey, "testprojectid" => testprojectid}
    return @server.call("tl.getFirstLevelTestSuitesForTestProject", args)
  end

  def getProjectsIdFromProjectName(name)
	getProjects().each do | p |
		if (p['name'] == name ) 
			return p['id']
		end 
	end	
  	return nil
  end

  def getProjectTestPlans(name)
  	testprojectid = getProjectsIdFromProjectName(name)	
  	args = {"devKey"=>@devKey, "testprojectid" => testprojectid }
  	return @server.call("tl.getProjectTestPlans", args)	
  end

  def getTestPlanIdFromProjectNameAndTestPlanName(testprojectname, name)
	getProjectTestPlans(testprojectname).each do | projects |
		if (projects['name'] == name ) 
			return projects['id']
		end 
	end
  	return nil
  end

  def getTestCasesForTestsuite(projectname, testsuiteid)
  	args = {"devKey"=>@devKey, "testsuiteid" => testsuiteid, "details"=>"full", "deep" => "true" }
  	return @server.call("tl.getTestCasesForTestSuite", args)
  end

  def getTestCasesForTestPlan(testprojectname,name)
  	testplanid = getTestPlanIdFromProjectNameAndTestPlanName(testprojectname,name)
  	args = {"devKey"=>@devKey, "testplanid" => testplanid }
  	return @server.call("tl.getTestCasesForTestPlan", args).values
  end

  def getTestCaseIdFromName(testprojectname,testcasename)
  	args = {"devKey"=>@devKey, "testcasename" => testcasename, "testprojectname" => testprojectname}
  	return @server.call("tl.getTestCaseIDByName", args)[0]
  end

end

def submitTCReport (testcasename, testprojectname, testplanname, buildname, status, notes)

  tl_client = TestlinkAPIClient.new()
  tl_client.reportTCResult(testprojectname, testplanname, testcasename, status, notes, buildname)
  
end
