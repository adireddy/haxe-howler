/**
 * Created by Adi Mora on 05/11/2014.
 */
module.exports = function (grunt) {

    grunt.initConfig({
        pkg: grunt.file.readJSON("package.json"),

        zip: {
            "howler.zip": ["howler/**", "haxelib.json"]
        }
    });

    grunt.loadNpmTasks("grunt-zip");
    grunt.registerTask("default", ["zip"]);
};