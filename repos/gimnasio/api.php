<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, GET");
header("Access-Control-Allow-Headers: Access-Control-Allow-Headers, Content-Type, Access-Control-Allow-Methods, Authorization, X-Requested-With");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "gimnasio";

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
    die(json_encode(array('status' => 'error', 'message' => 'Connection failed: ' . $conn->connect_error)));
}

// Obtener método de solicitud
$method = $_SERVER['REQUEST_METHOD'];
$input = json_decode(file_get_contents('php://input'), true);

switch ($method) {
    case 'POST':
        if (isset($input['action'])) {
            $action = $input['action'];

            switch ($action) {
                case 'registrar':
                    $stmt = $conn->prepare("INSERT INTO users (nombre, apellido, genero, email, password, edad, altura, peso, objetivo, semanas) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                    $password_hashed = password_hash($input['password'], PASSWORD_BCRYPT);
                    $stmt->bind_param("ssssssssss", $input['nombre'], $input['apellido'], $input['genero'], $input['email'], $password_hashed, $input['edad'], $input['altura'], $input['peso'], $input['objetivo'], $input['semanas']);
                    if ($stmt->execute()) {
                        echo json_encode(array('status' => 'success'));
                    } else {
                        echo json_encode(array('status' => 'error', 'message' => 'Error al registrar: ' . $stmt->error));
                    }
                    $stmt->close();
                    break;

                    case 'login':
                        $stmt = $conn->prepare("SELECT * FROM users WHERE email = ?");
                        $stmt->bind_param("s", $input['email']);
                        $stmt->execute();
                        $result = $stmt->get_result();
                    
                        if ($result->num_rows > 0) {
                            $user = $result->fetch_assoc();
                            if (password_verify($input['password'], $user['password'])) {
                                echo json_encode(array(
                                    'status' => 'success',
                                    'user_data' => array(
                                        'id' => $user['id'],
                                        'nombre' => $user['nombre'],
                                        'apellido' => $user['apellido'],
                                        'genero' => $user['genero'],
                                        'email' => $user['email'],
                                        'edad' => $user['edad'],
                                        'altura' => $user['altura'],
                                        'peso' => $user['peso'],
                                        'objetivo' => $user['objetivo'],
                                        'semanas' => $user['semanas'],
                                        'role' => $user['role']  // Añadimos el rol del usuario
                                    )
                                ));
                            } else {
                                echo json_encode(array('status' => 'error', 'message' => 'Contraseña incorrecta '));
                            }
                        } else {
                            echo json_encode(array('status' => 'error', 'message' => 'Usuario no encontrado'));
                        }
                        $stmt->close();
                        break;
                    

                        case 'get_users':
                            $query = "SELECT * FROM users";
                            $result = $conn->query($query);
                            $users = [];
                            while ($row = $result->fetch_assoc()) {
                                $users[] = $row;
                            }
                            echo json_encode($users);
                            break;
                        
                        case 'add_user':
                            $name = $_POST['name'];
                            $email = $_POST['email'];
                            // más campos
                            $query = "INSERT INTO users (nombre, email, ...) VALUES ('$name', '$email', ...)";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al agregar usuario']);
                            }
                            break;
                        
                        case 'edit_user':
                            $id = $_POST['id'];
                            $name = $_POST['name'];
                            // más campos
                            $query = "UPDATE users SET nombre='$name', email='$email', ... WHERE id='$id'";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al editar usuario']);
                            }
                            break;
                        
                        case 'delete_user':
                            $id = $_POST['id'];
                            $query = "DELETE FROM users WHERE id='$id'";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al eliminar usuario']);
                            }
                            break;
                        
                        case 'get_diets':
                            $query = "SELECT * FROM dietas";
                            $result = $conn->query($query);
                            $diets = [];
                            while ($row = $result->fetch_assoc()) {
                                $diets[] = $row;
                            }
                            echo json_encode($diets);
                            break;
                        
                        case 'add_diet':
                            $name = $_POST['name'];
                            $type = $_POST['type'];
                            // más campos
                            $query = "INSERT INTO dietas (nombre, tipo, ...) VALUES ('$name', '$type', ...)";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al agregar dieta']);
                            }
                            break;
                        
                        case 'edit_diet':
                            $id = $_POST['id'];
                            $name = $_POST['name'];
                            // más campos
                            $query = "UPDATE dietas SET nombre='$name', tipo='$type', ... WHERE id='$id'";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al editar dieta']);
                            }
                            break;
                        
                        case 'delete_diet':
                            $id = $_POST['id'];
                            $query = "DELETE FROM dietas WHERE id='$id'";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al eliminar dieta']);
                            }
                            break;
                        
                        case 'get_exercises':
                            $query = "SELECT * FROM ejercicios";
                            $result = $conn->query($query);
                            $exercises = [];
                            while ($row = $result->fetch_assoc()) {
                                $exercises[] = $row;
                            }
                            echo json_encode($exercises);
                            break;
                        
                        case 'add_exercise':
                            $name = $_POST['name'];
                            $video_url = $_POST['video_url'];
                            // más campos
                            $query = "INSERT INTO ejercicios (nombre, video_url, ...) VALUES ('$name', '$video_url', ...)";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al agregar ejercicio']);
                            }
                            break;
                        
                        case 'edit_exercise':
                            $id = $_POST['id'];
                            $name = $_POST['name'];
                            // más campos
                            $query = "UPDATE ejercicios SET nombre='$name', video_url='$video_url', ... WHERE id='$id'";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al editar ejercicio']);
                            }
                            break;
                        
                        case 'delete_exercise':
                            $id = $_POST['id'];
                            $query = "DELETE FROM ejercicios WHERE id='$id'";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al eliminar ejercicio']);
                            }
                            break;
                        
                        case 'get_meals':
                            $query = "SELECT * FROM comidas";
                            $result = $conn->query($query);
                            $meals = [];
                            while ($row = $result->fetch_assoc()) {
                                $meals[] = $row;
                            }
                            echo json_encode($meals);
                            break;
                        
                        case 'add_meal':
                            $dieta_id = $_POST['dieta_id'];
                            $dia = $_POST['dia'];
                            $tipo_comida = $_POST['tipo_comida'];
                            $comida = $_POST['comida'];
                            $cantidad = $_POST['cantidad'];
                            $ingredientes = $_POST['ingredientes'];
                            $preparacion = $_POST['preparacion'];
                            $semana = $_POST['semana'];
                        
                            $query = "INSERT INTO comidas (dieta_id, dia, tipo_comida, comida, cantidad, ingredientes, preparacion, semana) 
                                      VALUES ('$dieta_id', '$dia', '$tipo_comida', '$comida', '$cantidad', '$ingredientes', '$preparacion', '$semana')";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al agregar comida']);
                            }
                            break;
                        
                        case 'edit_meal':
                            $id = $_POST['id'];
                            $dieta_id = $_POST['dieta_id'];
                            $dia = $_POST['dia'];
                            $tipo_comida = $_POST['tipo_comida'];
                            $comida = $_POST['comida'];
                            $cantidad = $_POST['cantidad'];
                            $ingredientes = $_POST['ingredientes'];
                            $preparacion = $_POST['preparacion'];
                            $semana = $_POST['semana'];
                        
                            $query = "UPDATE comidas 
                                      SET dieta_id='$dieta_id', dia='$dia', tipo_comida='$tipo_comida', comida='$comida', cantidad='$cantidad', 
                                          ingredientes='$ingredientes', preparacion='$preparacion', semana='$semana' 
                                      WHERE id='$id'";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al editar comida']);
                            }
                            break;
                        
                        case 'delete_meal':
                            $id = $_POST['id'];
                            $query = "DELETE FROM comidas WHERE id='$id'";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al eliminar comida']);
                            }
                            break;
                        
                        case 'get_user_diets':
                            $query = "SELECT * FROM user_dietas";
                            $result = $conn->query($query);
                            $user_diets = [];
                            while ($row = $result->fetch_assoc()) {
                                $user_diets[] = $row;
                            }
                            echo json_encode($user_diets);
                            break;
                        
                        case 'add_user_diet':
                            $user_id = $_POST['user_id'];
                            $dieta_id = $_POST['dieta_id'];
                        
                            $query = "INSERT INTO user_dietas (user_id, dieta_id) VALUES ('$user_id', '$dieta_id')";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al agregar dieta de usuario']);
                            }
                            break;
                        
                        case 'edit_user_diet':
                            $id = $_POST['id'];
                            $user_id = $_POST['user_id'];
                            $dieta_id = $_POST['dieta_id'];
                        
                            $query = "UPDATE user_dietas SET user_id='$user_id', dieta_id='$dieta_id' WHERE id='$id'";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al editar dieta de usuario']);
                            }
                            break;
                        
                        case 'delete_user_diet':
                            $id = $_POST['id'];
                            $query = "DELETE FROM user_dietas WHERE id='$id'";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al eliminar dieta de usuario']);
                            }
                            break;
                        
                        case 'get_user_plans':
                            $query = "SELECT * FROM usuario_planes";
                            $result = $conn->query($query);
                            $user_plans = [];
                            while ($row = $result->fetch_assoc()) {
                                $user_plans[] = $row;
                            }
                            echo json_encode($user_plans);
                            break;
                        
                        case 'add_user_plan':
                            $user_id = $_POST['user_id'];
                            $plan_id = $_POST['plan_id'];
                        
                            $query = "INSERT INTO usuario_planes (user_id, plan_id) VALUES ('$user_id', '$plan_id')";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al agregar plan de usuario']);
                            }
                            break;
                        
                        case 'edit_user_plan':
                            $id = $_POST['id'];
                            $user_id = $_POST['user_id'];
                            $plan_id = $_POST['plan_id'];
                        
                            $query = "UPDATE usuario_planes SET user_id='$user_id', plan_id='$plan_id' WHERE id='$id'";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al editar plan de usuario']);
                            }
                            break;
                        
                        case 'delete_user_plan':
                            $id = $_POST['id'];
                            $query = "DELETE FROM usuario_planes WHERE id='$id'";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al eliminar plan de usuario']);
                            }
                            break;
                        
                        case 'get_plans':
                            $query = "SELECT * FROM planes";
                            $result = $conn->query($query);
                            $plans = [];
                            while ($row = $result->fetch_assoc()) {
                                $plans[] = $row;
                            }
                            echo json_encode($plans);
                            break;
                        
                        case 'add_plan':
                            $nombre = $_POST['nombre'];
                            $imagen = $_POST['imagen'];
                            $descripcion = $_POST['descripcion'];
                            $duracion = $_POST['duracion'];
                        
                            $query = "INSERT INTO planes (nombre, imagen, descripcion, duracion) 
                                      VALUES ('$nombre', '$imagen', '$descripcion', '$duracion')";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al agregar plan']);
                            }
                            break;
                        
                        case 'edit_plan':
                            $id = $_POST['id'];
                            $nombre = $_POST['nombre'];
                            $imagen = $_POST['imagen'];
                            $descripcion = $_POST['descripcion'];
                            $duracion = $_POST['duracion'];
                        
                            $query = "UPDATE planes 
                                      SET nombre='$nombre', imagen='$imagen', descripcion='$descripcion', duracion='$duracion' 
                                      WHERE id='$id'";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al editar plan']);
                            }
                            break;
                        
                        case 'delete_plan':
                            $id = $_POST['id'];
                            $query = "DELETE FROM planes WHERE id='$id'";
                            if ($conn->query($query)) {
                                echo json_encode(['status' => 'success']);
                            } else {
                                echo json_encode(['status' => 'error', 'message' => 'Error al eliminar plan']);
                            }
                            break;
                        
                                            
                    
                    
    
                    case 'reset_password':
                        $password_hashed = password_hash($input['new_password'], PASSWORD_BCRYPT);
                        $stmt = $conn->prepare("UPDATE users SET password = ? WHERE id = ?");
                        $stmt->bind_param("si", $password_hashed, $input['id']);
                        if ($stmt->execute()) {
                            echo json_encode(array('status' => 'success', 'message' => 'Contraseña actualizada exitosamente'));
                        } else {
                            echo json_encode(array('status' => 'error', 'message' => 'Error al actualizar la contraseña'));
                        }
                        $stmt->close();
                        break;
                
                    case 'remove_dieta':
                        $user_id = $input['user_id'];
                        $dieta_id = $input['dieta_id'];
                        $stmt = $conn->prepare("DELETE FROM user_dietas WHERE user_id = ? AND dieta_id = ?");
                        $stmt->bind_param("ii", $user_id, $dieta_id);
                        if ($stmt->execute()) {
                            echo json_encode(array('status' => 'success'));
                        } else {
                            echo json_encode(array('status' => 'error', 'message' => 'Error al eliminar la dieta'));
                        }
                        $stmt->close();
                        break;
                    
                        case 'remove_plan':
                            $user_id = $input['user_id'];
                            $plan_id = $input['plan_id'];
                            $stmt = $conn->prepare("DELETE FROM usuario_planes WHERE user_id = ? AND plan_id = ?");
                            $stmt->bind_param("ii", $user_id, $plan_id);
                            if ($stmt->execute()) {
                                echo json_encode(array('status' => 'success'));
                            } else {
                                echo json_encode(array('status' => 'error', 'message' => 'Error al eliminar el plan'));
                            }
                            $stmt->close();
                            break;
                    

                case 'get_dietas':
                    $sql = "SELECT * FROM dietas";
                    $result = $conn->query($sql);
                    $dietas = [];
                    if ($result->num_rows > 0) {
                        while ($row = $result->fetch_assoc()) {
                            $dietas[] = $row;
                        }
                    }
                    echo json_encode($dietas);
                    break;

                case 'get_comidas':
                    $dieta_id = $input['dieta_id'];
                    $stmt = $conn->prepare("SELECT * FROM comidas WHERE dieta_id = ?");
                    $stmt->bind_param("i", $dieta_id);
                    $stmt->execute();
                    $result = $stmt->get_result();
                    $comidas = [];
                    if ($result->num_rows > 0) {
                        while ($row = $result->fetch_assoc()) {
                            $comidas[] = $row;
                        }
                    }
                    echo json_encode($comidas);
                    $stmt->close();
                    break;

                case 'assign_dieta':
                    $user_id = $input['user_id'];
                    $dieta_id = $input['dieta_id'];
                    $stmt = $conn->prepare("SELECT * FROM user_dietas WHERE user_id = ? AND dieta_id = ?");
                    $stmt->bind_param("ii", $user_id, $dieta_id);
                    $stmt->execute();
                    $result = $stmt->get_result();

                    if ($result->num_rows == 0) {
                        $stmt = $conn->prepare("INSERT INTO user_dietas (user_id, dieta_id) VALUES (?, ?)");
                        $stmt->bind_param("ii", $user_id, $dieta_id);
                        if ($stmt->execute()) {
                            echo json_encode(array('status' => 'success'));
                        } else {
                            echo json_encode(array('status' => 'error', 'message' => 'Error al asignar dieta'));
                        }
                    } else {
                        echo json_encode(array('status' => 'error', 'message' => 'Dieta ya asignada'));
                    }
                    $stmt->close();
                    break;

                case 'assign_plan':
                    $user_id = $input['user_id'];
                    $plan_id = $input['plan_id'];
                    $stmt = $conn->prepare("SELECT * FROM usuario_planes WHERE user_id = ? AND plan_id = ?");
                    $stmt->bind_param("ii", $user_id, $plan_id);
                    $stmt->execute();
                    $result = $stmt->get_result();

                    if ($result->num_rows == 0) {
                        $stmt = $conn->prepare("INSERT INTO usuario_planes (user_id, plan_id) VALUES (?, ?)");
                        $stmt->bind_param("ii", $user_id, $plan_id);
                        if ($stmt->execute()) {
                            echo json_encode(array('status' => 'success'));
                        } else {
                            echo json_encode(array('status' => 'error', 'message' => 'Error al asignar plan'));
                        }
                    } else {
                        echo json_encode(array('status' => 'error', 'message' => 'Plan ya asignado'));
                    }
                    $stmt->close();
                    break;

                case 'get_planes':
                    $sql = "SELECT * FROM planes";
                    $result = $conn->query($sql);
                    $planes = [];
                    if ($result->num_rows > 0) {
                        while ($row = $result->fetch_assoc()) {
                            $planes[] = $row;
                        }
                    }
                    echo json_encode($planes);
                    break;

                case 'get_user_dietas':
                    $user_id = $input['user_id'];
                    $stmt = $conn->prepare("SELECT d.* FROM dietas d JOIN user_dietas ud ON d.id = ud.dieta_id WHERE ud.user_id = ?");
                    $stmt->bind_param("i", $user_id);
                    $stmt->execute();
                    $result = $stmt->get_result();
                    $dietas = [];
                    while ($row = $result->fetch_assoc()) {
                        $dietas[] = $row;
                    }
                    echo json_encode($dietas);
                    $stmt->close();
                    break;

                    case 'update_profile':
                        $stmt = $conn->prepare("UPDATE users SET nombre = ?, apellido = ?, email = ?, edad = ?, altura = ?, peso = ?, objetivo = ?, semanas = ? WHERE id = ?");
                        $stmt->bind_param("ssssddssi", $input['nombre'], $input['apellido'], $input['email'], $input['edad'], $input['altura'], $input['peso'], $input['objetivo'], $input['semanas'], $input['id']);
                    
                        if ($stmt->execute()) {
                            echo json_encode(array('status' => 'success', 'message' => 'Perfil actualizado correctamente'));
                        } else {
                            echo json_encode(array('status' => 'error', 'message' => 'Error al actualizar el perfil: ' . $stmt->error));
                        }
                        $stmt->close();
                        break;
                
                        case 'get_ejercicios':
                            $plan_id = $input['plan_id'];
                            $stmt = $conn->prepare("SELECT * FROM ejercicios WHERE plan_id = ?");
                            $stmt->bind_param("i", $plan_id);
                            $stmt->execute();
                            $result = $stmt->get_result();
                            $ejercicios = [];
                            if ($result->num_rows > 0) {
                                while ($row = $result->fetch_assoc()) {
                                    $ejercicios[] = $row;
                                }
                            }
                            echo json_encode(array('ejercicios' => $ejercicios));

                            $stmt->close();
                            break;
        
                            
                            // Envuelve la respuesta en un objeto
                        
                        
                case 'get_user_planes':
                    $user_id = $input['user_id'];
                    $stmt = $conn->prepare("SELECT p.* FROM planes p JOIN usuario_planes up ON p.id = up.plan_id WHERE up.user_id = ?");
                    $stmt->bind_param("i", $user_id);
                    $stmt->execute();
                    $result = $stmt->get_result();
                    $planes = [];
                    while ($row = $result->fetch_assoc()) {
                        $planes[] = $row;
                    }
                    echo json_encode($planes);
                    $stmt->close();
                    break;

                default:
                    echo json_encode(array('status' => 'error', 'message' => 'Acción no soportada'));
                    break;
            }
        } else {
            echo json_encode(array('status' => 'error', 'message' => 'No se especificó ninguna acción'));
        }
        break;
        case 'update_profile':
            $stmt = $conn->prepare("UPDATE users SET nombre = ?, apellido = ?, email = ?, edad = ?, altura = ?, peso = ?, objetivo = ?, semanas = ? WHERE id = ?");
            $stmt->bind_param("ssssddssi", $input['nombre'], $input['apellido'], $input['email'], $input['edad'], $input['altura'], $input['peso'], $input['objetivo'], $input['semanas'], $input['id']);
        
            if ($stmt->execute()) {
                echo json_encode(array('status' => 'success', 'message' => 'Perfil actualizado correctamente'));
            } else {
                echo json_encode(array('status' => 'error', 'message' => 'Error al actualizar el perfil: ' . $stmt->error));
            }
            $stmt->close();
            break;
        

}

