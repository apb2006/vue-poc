Tasks

* Server code `rxq-tasks.xqm`
* Are defined in `taskdef.xml`

* Each run is logged to `vue-poc/history.xml`

* UI vp-paramform

##Process

Get task

```
{
	"values": {
		"string1": "default string",
		"boolean1": false,
		"integer1": 42
	}
}
```

Post run

```
<hist:event xmlns:hist="urn:quodatum:vue-poc.history" id="ev-16" when="2020-12-02T20:34:28.475Z" user="admin">
    <task task="test" url="file:///C:/Users/andy/basex.home/webapp/vue-poc/features/tasks/task/test.xq">
      <param name="string1">default string</param>
      <param name="boolean1">false</param>
      <param name="integer1">42</param>
    </task>
  </hist:event>
```
Get run

##query-a

###inspect()

```
<json type="object">
  <description>test of parameter type handling</description>
  <updating type="boolean">true</updating>
  <url>C:\Users\andy\git\vue-poc\src\vue-poc\features\tasks\task\test.xq</url>
  <fields type="array">
    <_ type="object">
      <model>string1</model>
      <label>A simple string</label>
      <type>xs:string</type>
    </_>
    <_ type="object">
      <model>boolean1</model>
      <label>a boolean</label>
      <type>xs:boolean</type>
    </_>
    <_ type="object">
      <model>integer1</model>
      <label>an integer</label>
      <type>xs:integer</type>
    </_>
  </fields>
  <values type="object">
    <string1>default string</string1>
    <boolean1 type="boolean">false</boolean1>
    <integer1 type="number">42</integer1>
  </values>
</json>
```