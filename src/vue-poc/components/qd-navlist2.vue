<!DOCTYPE html>
<!-- 
for nav drawer
 -->
<template id="qd-navlist2">
 <v-list dense nav>
    <template v-for="(item, i) in items">
      <v-list-group
            v-if="item.children"
            :key="item.text"
            v-model="item.model"
            :prepend-icon="item.icon"   
            :title="item.text"
          >
            <template v-slot:activator>
              <v-list-item >
                <v-list-item-content>
                  <v-list-item-title>
                    {{ item.text }}
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </template>
             <v-divider :inset="true"></v-divider>
            <v-list-item :to="child.href"
              v-for="(child, i) in item.children"
              :key="i" :title="child.text"
            >
	          <v-list-item-icon>
	            <v-icon v-if="mini" v-text="child.icon"></v-icon>
	          </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title>
                  {{ child.text }}
                </v-list-item-title>
              </v-list-item-content>
               <v-list-item-action>
              <v-icon v-text="child.icon"></v-icon>
            </v-list-item-action>
            </v-list-item>
            <v-divider :inset="true"></v-divider>
          </v-list-group>

          
            <v-list-item v-else :key="item.text"  :to="item.href" >
            <v-list-item-action>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>
                {{ item.text }}
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
          </template>
        </v-list>
</template>

<script>{
  props: ['items','mini']
}
</script>
