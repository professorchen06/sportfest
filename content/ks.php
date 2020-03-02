<?php
	//query for new ks
	if(isset($_GET["sub"]) AND $_GET["sub"] == "newq") {										//Klassenstufe in DB eintragen

		$nummer	= $_POST["nummer"];
		$end 	= false;
		$disziplinen = [];
		$i=1;
		while(!$end){
			if(isset($_GET['disziplin' + $i]) && isset($_GET['disziplingruppe' + $i])){
				$disziplinen[] = ["name" => $_GET['disziplin' + i],
						  "gruppe" => $_GET['disziplingruppe' + $i]];
			}else{
				$end = true;
			}
		}

		if($nummer != "") {
			if(mysqli_query($GLOBALS["dbConnection"], "INSERT INTO klassenstufen (nummer) VALUES('$nummer')")&&
			  $id = mysqli_query($GLOBALS["dbConnection"], "SELECT id from klassenstufen WHERE nummer = " . $nummer . ";")&&insertklassedisziplin($id,$disziplinen))
				echo "Klassenstufe erfolgreich hinzugefügt";
			else
				echo "Es ist ein Fehler aufgetreten, falls dies noch einmal auftritt, dann kontaktieren sie bitte ihren Administrator."
		} else {
			echo "Das Feld 'Nummer' muss Ausgef&uuml;llt sein!";
		}
	}

	//query for changing elements
	if(isset($_GET["sub"]) AND $_GET["sub"] == "changeq") {										//geänderte Klassenstufe in DB eintragen
		$id		= $_POST["id"];
		$nummer	= $_POST["nummer"];
		$disz1	= $_POST["disz1"];
		$disz2	= $_POST["disz2"];
		$disz3	= $_POST["disz3"];
		$disz4  = $_POST["disz4"];

		if($nummer != "") {
			if(mysqli_query($GLOBALS["dbConnection"], "UPDATE klassenstufen SET nummer='$nummer', disziplin1='$disz1', disziplin2='$disz2', disziplin3='$disz3', disziplin4='$disz4' WHERE id = '$id'"))
				echo "&Auml;nderungen erfolgreich ausgeführt";
		} else {
			echo "nummernung muss Ausgef&uuml;llt sein!";
		}

	}

	//query for deleting elements
	if(isset($_GET["sub"]) AND $_GET["sub"] == "deleteq") {										//Klassenstufe löschen
		$id			= $_GET["id"];
		$check_query = mysqli_query($GLOBALS["dbConnection"], "SELECT id FROM klasse WHERE klassenstufe_id = '$id'");
		$count	= 0;
		while($row = mysqli_fetch_assoc($check_query)) {
			$count++;
		}
		if($count == 0) {
			if(mysqli_query($GLOBALS["dbConnection"], "DELETE FROM klassenstufen WHERE id = '$id'"))
				echo "L&ouml;schen erfolgreich ausgeführt";
			else
				echo "Es ist ein Fehler aufgetreten, falls dies noch einmal auftritt, dann kontaktieren sie bitte ihren Administrator.";
		} else {
			echo "Sie m&uuml;ssen vorher diese Klassenstufe aus allen Klassen entfernen, da es sonst zu fehlern kommen kann!";
		}
	}

	echo "<p>";
		echo "<a href='index.php?con=ks&sub=new'>Neue Klassenstufe Anlegen</a>";
	echo "</p>";

	//gennerate HTML Form for a new Element
	if(isset($_GET["sub"]) AND $_GET["sub"] == "new") {											//Anlegen der Klassenstufe
		if(isset($_GET['a_disziplin']))
			$a_disziplin = $_GET['a_disziplin'];
		else
			$a_disziplin = 1;
		echo "Klassenstufe erstellen";

		echo "<form action='index.php?con=ks&sub=newq' method='POST'>";
			echo "<table>";
				echo "<tr>";
					echo "<td>Nummer: </td>";
					echo "<td colspan='4'><input type='text' name='nummer' required/></td>";
				echo "</tr>";
				echo "<tr>";
					/* --deprecated
					for($for = 1; $for <= 4; $for++){
						echo "<td>";
							echo "<select name='disz",$for,"'>";
								echo "<option/>";
								$disz_query = mysqli_query($GLOBALS["dbConnection"], "SELECT id,bezeichnung FROM disziplin");
								while($row = mysqli_fetch_assoc($disz_query)){
									$disz_id	= $row["id"];
									$bezeich	= $row["bezeichnung"];
									echo "<option value='$disz_id'>$bezeich</option>";
								}
							echo "</select>";
						echo "</td>";
					}*/
					for($i=0;$i<$a_disziplin;$i++){
						echo "<td>";
							echo "<select name=\"disz\"" . $i . ">";
								echo "<option/>";
								$disz_query = mysqli_query($GLOBALS["dbConnection"], "SELECT id,bezeichnung FROM disziplin");
								while($row = mysqli_fetch_assoc($disz_query)){
									$disz_id	= $row["id"];
									$bezeich	= $row["bezeichnung"];
									echo "<option value='$disz_id'>$bezeich</option>";
								}
							echo "</select>";
						echo "</td>
						<td>
							<input type=\"number\" name=\"diszgroup" . $i . "\" required>
						</td>";
					}
					echo "<tr><td><a href=\"?con=ks&sub=new&a_disziplin=" . ($a_disziplin + 1) . "\">Neue Zeile</a></td></tr>";
					echo "<td><input type='submit' value='create'></td>";
			echo "</table>";
		echo "</form>";
	}

	//gennerate HTML Form for changing Elements
	if(isset($_GET["sub"]) AND $_GET["sub"] == "change") {											//Change ausf�llen
		if(isset($_GET['a_disziplin']))
			$a_disziplin = $_GET['a_disziplin'];
		else
			$a_disziplin = 1;
		echo "change klassenstufe";
		$id = $_GET["id"];
		$ks_query 	= mysqli_query($GLOBALS["dbConnection"], "SELECT * FROM klassenstufen WHERE id = '$id'");
		while($row 	= mysqli_fetch_assoc($ks_query)) {												//Mit aktuellen werten ausgeben
			$nummer	= $row["nummer"];
			/* --deprecated
			$disziplin1	= $row["disziplin1"];
			$disziplin2	= $row["disziplin2"];
			$disziplin3	= $row["disziplin3"];
			$disziplin4	= $row["disziplin4"];*/
		}
		echo "<form action='index.php?con=ks&sub=changeq' method='POST'>";
			echo "<table>";
				echo "<tr>";
					echo "<td>Nummer: </td>";
					echo "<td><input type='text' name='nummer' value='",$nummer,"'required/></td>";
				echo "</tr><tr>";
				/*--deprecrated
				for($for = 1; $for <= 4; $for++){
						echo "<td>";
							echo "<select name='disz",$for,"'>";
								$disz_ueid 	= "disziplin$for";				//�bergangsvariable
								$diszold_id	= $$disz_ueid;
								$disz_query = mysqli_query($GLOBALS["dbConnection"], "SELECT id,bezeichnung FROM disziplin");
								while($row = mysqli_fetch_assoc($disz_query)){
									$disz_id	= $row["id"];
									$bezeich	= $row["bezeichnung"];
									if($disz_id == $diszold_id) {
										echo "<option value='$disz_id' selected>$bezeich</option>";
									} else {
										echo "<option value='$disz_id'>$bezeich</option>";
									}
								}

							echo "</select>";
						echo "</td>";
					}*/
				if(!isset($_GET['ks']))
					exit("<b><pre>Error: No class specified! content/ks.php:177</pre></b>");
				$res = mysqli_query($GLOBALS["dbConnection"], "SELECT dk.gruppe, dk.id as dkid, ks.nummer, ks.id as ksid, d.id as did, d.bezeichnung FROM Disziplin-Klasse dk, klassenstufen ks, disziplin d WHERE ks.nummer='" . $_GET['ks'] . "' AND ks.id=dk.klasse_id AND d.id=dk.disziplin_id");
				$all_disziplins=mysqli_query($GLOBALS['connection'],"SELECT * form disziplin");
				echo "<h1>" . $_GET['ks'] . "</h1>";
				echo "<table>";
				$i=0;
				while($row = mysqli_fetch_assoc($res)){
					echo "<tr><td>";
					echo "<select name=\"dkid" . $row['dkid'] . "\">";
							echo "<option/>";
							$disz_query = $all_disziplins;
							while($drow = mysqli_fetch_assoc($disz_query)){
								$disz_id	= $drow["id"];
								$bezeich	= $drow["bezeichnung"];
								if($row['did']==$drow['id'])
									$sel="selected";
								else
									$sel="";
								echo "<option value='$disz_id' ' . $sel . '>$bezeich</option>";
							}
					echo "</select>";
					echo "</td><td><input type=\"number\" name=\"diszg" . $row['dkid'] .  "\"" . $row['gruppe'] . "</td></tr>";
				}

				echo "</table>";
					for($i=0;$i<$a_disziplin;$i++){
						echo "<td>";
							echo "<select name=\"disznew\"" . $i . ">";
								echo "<option/>";
								$disz_query = mysqli_query($GLOBALS["dbConnection"], "SELECT id,bezeichnung FROM disziplin");
								while($row = mysqli_fetch_assoc($disz_query)){
									$disz_id	= $row["id"];
									$bezeich	= $row["bezeichnung"];
									echo "<option value='$disz_id'>$bezeich</option>";
								}
							echo "</select>";
						echo "</td>
						<td>
							<input type=\"number\" name=\"diszgroupnew" . $i . "\" required>
						</td>";
					}

					echo "<td colspan='2'>";
						echo "<input type='hidden' name='id' value='",$id,"'>";
						echo "<input type='submit' value='change'>";
						echo "</td>";
			echo "</table>";
		echo "</form>";
	}

//show detailed information for one element
	if(isset($_GET['sub']) && $_GET['sub']="showone"){
		if(!isset($_GET['ks']))
			exit("<b><pre>Error: No class specified! content/ks.php:177</pre></b>");
		$res = mysqli_query($GLOBALS["dbConnection"], "SELECT * FROM Disziplin-Klasse dk, klassenstufen ks, disziplinen d WHERE ks.nummer='" . $_GET['ks'] . "' AND ks.id=dk.klasse_id AND d.id=dk.disziplin_id");
		echo "<h1>" . $_GET['ks'] . "</h1>";
		echo "<table>";
		while($row = mysqli_fetch_assoc($res)){
			echo "<tr><td>" . $row['bezeichnung'] . "</td><td>" . $row['gruppe'] . "</td></tr>";
		}
		
		echo "</table>";
		
	}

	$ks_query = mysqli_query($GLOBALS["dbConnection"], "SELECT * FROM klassenstufen ORDER BY nummer");							//echo ALL disziplins
	echo "<table border='1'>";
	while($row = mysqli_fetch_assoc($ks_query)) {
		echo "<tr>";
			$id			= $row["id"];
			$nummer		= $row["nummer"];
			/* --deprecated
			$disziplin1	= $row["disziplin1"];
			$disziplin2	= $row["disziplin2"];
			$disziplin3	= $row["disziplin3"];
			$disziplin4	= $row["disziplin4"];*/

			echo "<td><a href=\"index.php?con=ks&sub=showone&?id=" . $id . "\"",$nummer,"</td>";

			/* --deprecated
			for($for = 1;$for <= 4;$for++) {
				$disz_ueid 	= "disziplin$for";				//�bergangsvariable
				$disz_id	= $$disz_ueid;

				$disz_query = mysqli_query($GLOBALS["dbConnection"], "SELECT * FROM disziplin WHERE id = '$disz_id'");
				echo "<td>";
				while($row 	= mysqli_fetch_assoc($disz_query)) {
					echo $row["bezeichnung"];
				}
				echo "</td>";
			}*/

			echo "<td><a href='index.php?con=ks&sub=change&id=",$id,"'>Bearbeien</a></td>";
			echo "<td><a href='index.php?con=ks&sub=deleteq&id=",$id,"'>Löschen</a></td>";
			echo "</tr><tr>";

		echo "</tr>";
	}
	echo "</table>";

//function for inserting one ks into the db
function insertklassedisziplin($id, $disziplinen){
	$query = "INSERT into Disziplin-Klasse (klasse_id, disziplin_id, wahl_gruppe) VALUES (";
	foreach($disziplinen as $disziplin){
		$query .= "(" . $id . "," . $disziplin['name'] . "," . $disziplin['gruppe'] . ")";
	}
	$query.= ");";
	mysqli_query($GLOBALS["dbConnection"], $query);
}
?>
